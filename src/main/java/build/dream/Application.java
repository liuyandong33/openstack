package build.dream;

import java.io.*;

public class Application {
    public static void main(String[] args) throws IOException {
        FileInputStream fileInputStream = new FileInputStream("E:\\workspace\\openstack\\rocky\\controller\\install\\config\\metadata_agent.ini");
        InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream);
        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

        String line = null;
        while ((line = bufferedReader.readLine()) != null) {
            if (line.startsWith("[")) {
                System.out.println(line);
                System.out.println();
            }
        }
    }
}
