using System;
using System.Collections;
using System.Collections.Generic;

public class BinarySearchTree : IEnumerable<int>
{
    private BinarySearchTree left = null;
    private BinarySearchTree right = null;
    private int? value = null;
    
    public BinarySearchTree(int value)
    {
        this.Add(value);
    }

    public BinarySearchTree(IEnumerable<int> values)
    {
        foreach (var value in values)
        {
            this.Add(value);
        }
    }

    public int Value
    {
        get { return value ?? 0; }
    }

    public BinarySearchTree Left
    {
        get { return left; }
    }

    public BinarySearchTree Right
    {
        get { return right; }
    }

    public BinarySearchTree Add(int value)
    {
        if (!this.value.HasValue)
        {
            this.value = value;
            return this;
        }
        else
        {
            if (this.value.Value >= value)
            {
                if (Left == null)
                    left = new BinarySearchTree(value);
                else
                    left = Left.Add(value);
                return this;
            }
            else
            {
                if (Right == null)
                    right = new BinarySearchTree(value);
                else
                    right = Right.Add(value);
                return this;
            }
        }
    }

    public IEnumerator<int> GetEnumerator()
    {
        List<int> enumerator = new List<int>();
        if (Left != null)
        {
            foreach (var val in Left)
                enumerator.Add(val);
        }
        enumerator.Add(Value);
        if (Right != null)
        {
            foreach (var val in Right)
                enumerator.Add(val);
	}
        return enumerator.GetEnumerator();
    }

    IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
}
