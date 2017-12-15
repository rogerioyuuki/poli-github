package com.kipple.runtime;

public final class AsciiStack extends BaseStack {
    @Override
    public void push(int val) {
        String s = Integer.toString(val);
        for (int i = 0; i < s.length(); i++) {
            super.push((int) s.charAt(i));
        }
    }
}
