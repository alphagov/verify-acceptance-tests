package uk.gov.gds.verify.smoketest;

import picocli.CommandLine;

@CommandLine.Command(name = "ConcourseBot",
        description = "Do things in Slack from ConcourseBot 🤖",
        subcommands = {FileUploadCommand.class, SendMessageCommand.class})
public class ConcourseBot implements Runnable {
    public static void main(String[] args) throws Exception {
        CommandLine application = new CommandLine(new ConcourseBot()).setCaseInsensitiveEnumValuesAllowed(true);
        application.execute(args);
        System.exit(0);
    }

    public void run() {
        CommandLine.usage(this, System.err);
    }
}
