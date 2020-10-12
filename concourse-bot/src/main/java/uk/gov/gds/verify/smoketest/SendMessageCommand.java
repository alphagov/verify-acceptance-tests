package uk.gov.gds.verify.smoketest;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import picocli.CommandLine;

import java.io.File;
import java.util.Objects;
import java.util.concurrent.Callable;

@CommandLine.Command(
        name = "send-message",
        description = "Send a message.\n\nRequired environment variables:\n\tSLACK_BOT_TOKEN\n\tCHANNEL\n\nSee: https://api.slack.com/messaging/sending\n\n")
public class SendMessageCommand implements Callable<Void> {
    private static String TOKEN = System.getenv("SLACK_BOT_TOKEN");
    private static String CHANNEL = System.getenv("CHANNEL");
    private static final String END_POINT = "https://slack.com/api/chat.postMessage";

    @CommandLine.Parameters(
            paramLabel = "message",
            description = "The message to send.")
    String message;

    @Override
    public Void call() throws Exception {

        if ( Objects.isNull(TOKEN) ) {
            System.err.println("SLACK_BOT_TOKEN needs to be set as an environment variable");
            CommandLine.usage(this, System.err);
            System.exit(1);
        }

        if ( Objects.isNull(CHANNEL) ) {
            System.err.println("CHANNEL needs to be set as an environment variable");
            CommandLine.usage(this, System.err);
            System.exit(1);
        }

        CloseableHttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost(END_POINT);
        post.setHeader("Accept", "application/json");
        post.setHeader("Content-type", "application/json");
        post.setHeader("Authorization", "Bearer " + TOKEN);

        String json = String.format("{\"channel\":\"%s\", \"text\":\"%s\"}", CHANNEL, message); // this should be much more robust
        StringEntity entity = new StringEntity(json);
        post.setEntity(entity);

        client.execute(post);
        return null;
    }
}
