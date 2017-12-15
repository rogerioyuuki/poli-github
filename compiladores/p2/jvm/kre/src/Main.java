import com.kipple.runtime.KippleRuntime;

public class Main {
    public static void main(String[] args) {
        KippleRuntime.init(args);

        while (KippleRuntime.isEmpty(97) != 1) {
            KippleRuntime.pop(97);
        }

        KippleRuntime.push(111, KippleRuntime.pop(98));

        KippleRuntime.printOutput();
    }
}
