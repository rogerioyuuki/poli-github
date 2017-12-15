package com.kipple.runtime;

import java.util.HashMap;

public final class KippleRuntime {
    private static HashMap<Integer, BaseStack> stacks = new HashMap<>(28, 1);

    private static BaseStack getStack(String idStack) {
        return stacks.get((int)idStack.charAt(0));
    }

    public static void init(String[] args) {
        stacks.put((int) "@".charAt(0), new AsciiStack());

        for (char idStack = 'a'; idStack <= 'z'; idStack++) {
            stacks.put((int) idStack, new KippleStack());
        }

        BaseStack input = getStack("i");
        for (int i = 0; i < args.length; i++) {
            String arg = args[i];
            for (int j = 0; j < arg.length(); j++) {
                input.push((int) arg.charAt(j));
            }
        }
    }

    public static void push(int idStack, int val) {
        stacks.get(idStack).push(val);
    }

    public static int pop(int idStack) {
        return stacks.get(idStack).pop();
    }

    public static void clear(int idStack) {
        stacks.get(idStack).clear();
    }

    public static int isEmpty(int idStack) {
        return stacks.get(idStack).isEmpty();
    }

    public static void add(int idStack, int val) {
        stacks.get(idStack).add(val);
    }
    
    public static void addStacks(int idStackLeft, int idStackRight) {
        stacks.get(idStackLeft).add(stacks.get(idStackRight));
    }

    public static void sub(int idStack, int val) {
        stacks.get(idStack).sub(val);
    }

    public static void subStacks(int idStackLeft, int idStackRight) {
        stacks.get(idStackLeft).sub(stacks.get(idStackRight));
    }

    public static void printOutput() {
        BaseStack stack = getStack("o");
        while (stack.isEmpty() != 1) {
            System.out.print((char)stack.pop());
        }
    }
}
