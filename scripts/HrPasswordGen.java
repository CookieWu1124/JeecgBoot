import org.jeecg.common.util.PasswordUtil;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class HrPasswordGen {
  public static void main(String[] args) throws Exception {
    if (args.length == 3) {
      System.out.print(PasswordUtil.encrypt(args[0], args[1], args[2]));
      return;
    }
    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in, "UTF-8"));
    String line;
    while ((line = reader.readLine()) != null) {
      if (line.isEmpty()) continue;
      String[] parts = line.split("\t", 3);
      System.out.println(PasswordUtil.encrypt(parts[0], parts[1], parts[2]));
    }
  }
}
