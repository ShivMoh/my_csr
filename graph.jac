node state {
    has title;
    has message;
    has prompts;
}

edge transition {
    has intent;
}

graph main_graph {
    has anchor main_root;

    spawn {
        main_root = spawn node::state(
                        title = "Greeting",
                        message = "Hi there, welcome. What can we build for you today?",
                        prompts = ["website", "mobile app", "information system", "quit"]
                    );

        website = spawn main_root -[transition(intent="website")]-> node::state(
            title = "Website",
            message = "What type of website would you like?",
            prompts = ["one pager", "two pager", "mlg", "back"]
        );

        website -[transition(intent = "back")] -> main_root;

        mobile_app = spawn main_root -[transition(intent="mobile app")]-> node::state(
            title = "Mobile app",
            message = "What kind of mobile apps do you like?",
            prompts = ["recreational", "educational", "professional", "back"]
        );

        mobile_app -[transition(intent = "back")] -> main_root;

        information_system = spawn main_root -[transition(intent="information system")]-> node::state(
            title = "Information System",
            message = "What do you know about information systems?",
            prompts = ["something about system", "something else", "back"]
        );

        information_system -[transition(intent = "back")] -> main_root;
    
    }
}