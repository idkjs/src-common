import java.io.*;
import java.net.*;

public class NetworkTcpClient {
 public static void main(String argv[]) throws Exception {
  String FromServer;
  String ToServer;

  Socket clientSocket = new Socket("localhost", 9876);

  BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));

  PrintWriter outToServer = new PrintWriter(clientSocket.getOutputStream(),true);

  BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

  while (true) {
    FromServer = inFromServer.readLine();

    if ( FromServer.equals("q") || FromServer.equals("Q")) {
        clientSocket.close();
        break;
    } else {
         System.out.println("RECIEVED:" + FromServer);
         System.out.println("SEND(Type Q or q to Quit):");

         ToServer = inFromUser.readLine();

         if (ToServer.equals("Q") || ToServer.equals("q")) {
         outToServer.println (ToServer) ;
         clientSocket.close();
            break;
         } else {
            outToServer.println(ToServer);
        }
      }
    }
  }
}
