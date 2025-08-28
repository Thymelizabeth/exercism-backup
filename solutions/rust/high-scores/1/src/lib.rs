#[derive(Debug)]
pub struct HighScores {
    best: Option<u32>,
    second_best: Option<u32>,
    third_best: Option<u32>,
    last_added: Option<u32>,
    scores: Vec<u32>,
}

impl HighScores {
    fn empty() -> Self {
        HighScores {
            best: None,
            second_best: None,
            third_best: None,
            last_added: None,
            scores: vec![],
        }
    }
    pub fn new(scores: &[u32]) -> Self {
        scores.iter().fold(HighScores::empty(), 
                           |acc, &elem| {
                               let mut result = HighScores { scores: vec![], ..acc };
                               match acc.best {
                                   Some(n) => {
                                       if elem >= n {
                                           result.third_best = acc.second_best;
                                           result.second_best = acc.best;
                                           result.best = Some(elem);
                                       } else {
                                           match acc.second_best {
                                               Some(o) => {
                                                   if elem >= o {
                                                       result.third_best = acc.second_best;
                                                       result.second_best = Some(elem);
                                                   } else {
                                                       match acc.third_best {
                                                           Some(p) => {
                                                               if elem >= p {
                                                                   result.third_best = Some(elem);
                                                               }
                                                           },
                                                           None => {
                                                               result.third_best = Some(elem);
                                                           }
                                                       }
                                                   }
                                               },
                                               None => {
                                                   result.second_best = Some(elem);
                                               }
                                           }
                                       }
                                   },
                                   None => {
                                       result.best = Some(elem);
                                   }
                               }
                               result.last_added = Some(elem);
                               acc.scores.iter().for_each(|e| result.scores.push(*e));
                               result.scores.push(elem);
                               eprintln!("{:?}", result);
                               result
                           } )
    }

    pub fn scores(&self) -> &[u32] {
        &self.scores
    }

    pub fn latest(&self) -> Option<u32> {
        self.last_added
    }

    pub fn personal_best(&self) -> Option<u32> {
        self.best
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        let mut result = vec![];
        if let Some(n) = self.best {
            result.push(n);
        } else {
            return result;
        }
        if let Some(n) = self.second_best {
            result.push(n);
        } else {
            return result;
        }
        if let Some(n) = self.third_best {
            result.push(n);
        } else {
            return result;
        }
        result
    }
}
