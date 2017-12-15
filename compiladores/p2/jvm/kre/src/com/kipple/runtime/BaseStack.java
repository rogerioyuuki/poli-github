package com.kipple.runtime;

import java.util.Stack;

abstract class BaseStack {
    private Stack<Integer> stack = new Stack<>();

    public int pop() {
        return stack.empty() ? 0 : stack.pop();
    }

    public int peek() {
        return stack.empty() ? 0 : stack.peek();
    }

    public void push(int val) {
        stack.push(val);
    }

    public int isEmpty() {
        return stack.empty() ? 1 : 0;
    }

    public void add(int val) {
        stack.push(peek() + val);
    }

    public void add(BaseStack s) {
        stack.push(peek() + s.pop());
    }

    public void sub(int val) {
        stack.push(peek() - val);
    }

    public void sub(BaseStack s) {
        stack.push(peek() - s.pop());
    }

    public void clear() {
        if (peek() == 0) stack.clear();
    }
}
