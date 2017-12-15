
LOOP0_START:    bipush 105
L0:    invokestatic Method com/kipple/runtime/KippleRuntime isEmpty (I)I
L1:    ifgt LOOP0_END
L2:    bipush 111
L3:    bipush 105
L4:    invokestatic Method com/kipple/runtime/KippleRuntime pop (I)I
L5:    invokestatic Method com/kipple/runtime/KippleRuntime push (II)V
L6:    goto LOOP0_START
LOOP0_END:    nop
L7:    invokestatic Method com/kipple/runtime/KippleRuntime printOutput ()V
L8:    return
    .end code
.end method
.sourcefile 'Main.java'
.end class