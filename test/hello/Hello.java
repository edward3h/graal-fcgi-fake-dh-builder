package hello;
/**
 *
 * @author edward
 */
public class Hello {
    public static void main(String[] args) {
        var message = "world";
        if (args.length > 0) {
            message = String.join(" ", args);
        }
        System.out.printf("Hello, %s.%n", message);
    }
}
