use std::{collections::HashMap, rc::Rc};

pub type Value = i32;
type Stack = Vec<Value>;
type Word = Rc<dyn Fn(Stack) -> Result<Stack, Error>>;

pub struct Forth {
    stack: Stack,
    env: HashMap<String, Word>,
}

#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    DivisionByZero,
    StackUnderflow,
    UnknownWord,
    InvalidWord,
}

impl Forth {
    pub fn new() -> Forth {
        Self {
            stack: Vec::new(),
            env: HashMap::from([
                ("+".to_string(), Rc::new(add) as Word),
                ("-".to_string(), Rc::new(sub)),
                ("*".to_string(), Rc::new(mult)),
                ("/".to_string(), Rc::new(div)),
                ("DUP".to_string(), Rc::new(dup)),
                ("DROP".to_string(), Rc::new(drop)),
                ("SWAP".to_string(), Rc::new(swap)),
                ("OVER".to_string(), Rc::new(over)),
                ("DEBUG".to_string(), Rc::new(debug)),
            ]),
        }
    }

    pub fn stack(&self) -> &[Value] {
        &self.stack
    }

    pub fn eval(&mut self, input: &str) -> Result<(), Error> {
        if let Some(b':') = input.bytes().next() {
            self.define_word(input)?;
        } else {
            self.run_words(input)?;
        }
        Ok(())
    }

    fn define_word(&mut self, input: &str) -> Result<(), Error> {
        match &input.split_whitespace().collect::<Vec<_>>().as_slice() {
            &[":", name, definition @ .., ";"] => {
                if name.parse::<Value>().is_ok() {
                    Err(Error::InvalidWord)
                } else {
                    let thunk: Word = definition.iter().try_fold(
                        Rc::from(Box::new(|stack: Stack| Ok(stack))
                            as Box<dyn Fn(Stack) -> Result<Stack, Error>>),
                        |acc: Word, word| {
                            if let Some(next) = self.env.get(&word.to_uppercase()) {
                                let next = Rc::clone(next);
                                Ok(Rc::new(move |stack| next(acc(stack)?)) as Word)
                            } else if let Ok(num) = word.parse::<Value>() {
                                Ok(Rc::new(move |stack| push_num(acc(stack)?, num)) as Word)
                            } else {
                                Err(Error::UnknownWord)
                            }
                        },
                    )?;
                    self.env.insert(name.to_uppercase(), thunk);
                    Ok(())
                }
            }
            _ => Err(Error::InvalidWord),
        }
    }

    fn run_words(&mut self, input: &str) -> Result<(), Error> {
        input.split_whitespace().try_fold((), |_acc, next_word| {
            if let Some(word) = self.env.get(&next_word.to_uppercase()) {
                self.stack = word(self.stack.clone())?;
                Ok(())
            } else if let Ok(num) = next_word.parse::<Value>() {
                self.stack = push_num(self.stack.clone(), num)?;
                Ok(())
            } else {
                Err(Error::UnknownWord)
            }
        })
    }
}

fn add(mut stack: Stack) -> Result<Stack, Error> {
    let x = stack.pop().ok_or(Error::StackUnderflow)?;
    let y = stack.pop().ok_or(Error::StackUnderflow)?;
    stack.push(x + y);
    Ok(stack)
}

fn sub(mut stack: Stack) -> Result<Stack, Error> {
    let x = stack.pop().ok_or(Error::StackUnderflow)?;
    let y = stack.pop().ok_or(Error::StackUnderflow)?;
    stack.push(y - x);
    Ok(stack)
}

fn mult(mut stack: Stack) -> Result<Stack, Error> {
    let x = stack.pop().ok_or(Error::StackUnderflow)?;
    let y = stack.pop().ok_or(Error::StackUnderflow)?;
    stack.push(x * y);
    Ok(stack)
}

fn div(mut stack: Stack) -> Result<Stack, Error> {
    let x = stack.pop().ok_or(Error::StackUnderflow)?;
    let y = stack.pop().ok_or(Error::StackUnderflow)?;
    if x == 0 {
        Err(Error::DivisionByZero)
    } else {
        stack.push(y / x);
        Ok(stack)
    }
}

fn dup(mut stack: Stack) -> Result<Stack, Error> {
    let x = stack.pop().ok_or(Error::StackUnderflow)?;
    stack.push(x);
    stack.push(x);
    Ok(stack)
}

fn drop(mut stack: Stack) -> Result<Stack, Error> {
    let _x = stack.pop().ok_or(Error::StackUnderflow)?;
    Ok(stack)
}

fn swap(mut stack: Stack) -> Result<Stack, Error> {
    let x = stack.pop().ok_or(Error::StackUnderflow)?;
    let y = stack.pop().ok_or(Error::StackUnderflow)?;
    stack.push(x);
    stack.push(y);
    Ok(stack)
}

fn over(mut stack: Stack) -> Result<Stack, Error> {
    let x = stack.pop().ok_or(Error::StackUnderflow)?;
    let y = stack.pop().ok_or(Error::StackUnderflow)?;
    stack.push(y);
    stack.push(x);
    stack.push(y);
    Ok(stack)
}

fn debug(stack: Stack) -> Result<Stack, Error> {
    eprintln!("{:?}", stack);
    Ok(stack)
}

fn push_num(mut stack: Stack, num: Value) -> Result<Stack, Error> {
    stack.push(num);
    Ok(stack)
}
