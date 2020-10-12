package uk.gov.gds.verify.smoketest;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;

import picocli.CommandLine;

import java.io.File;
import java.util.Objects;
import java.util.concurrent.Callable;

@CommandLine.Command(
        name = "upload-file",
        description = "Upload a file to  Slack.\n\nRequired environment variables:\n\tSLACK_BOT_TOKEN\n\tCHANNEL\n\nSee https://api.slack.com/methods/files.upload\n\n")
public class FileUploadCommand implements Callable<Void> {
    private static final String END_POINT = "https://slack.com/api/files.upload";
    private static String TOKEN = System.getenv("SLACK_BOT_TOKEN");
    private static String CHANNEL = System.getenv("CHANNELS");

    @CommandLine.Option(
            required = true,
            names = "--file",
            description = "The file to upload.")
    File file;

    @CommandLine.Option(
            names = "--comment",
            description = "A comment to go with the file.")
    String comment;

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

        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        builder.addBinaryBody("file", file, ContentType.DEFAULT_BINARY, file.getName());
        builder.addTextBody("token", TOKEN, ContentType.DEFAULT_BINARY);
        builder.addTextBody("channels", CHANNEL, ContentType.DEFAULT_BINARY);
        if (!Objects.isNull(comment)) {
            builder.addTextBody("initial_comment", comment, ContentType.DEFAULT_BINARY);
        }
        HttpEntity entity = builder.build();
        post.setEntity(entity);
        client.execute(post);
        return null;
    }
}
