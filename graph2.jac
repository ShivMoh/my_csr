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
        all_prompts = {
            'starter_prompts': ["mobile_app", "info_sys", "website", "quit"],
            'mobile_app': ['game', 'social', 'other', 'back'],
            'website': ["one_pager", "5-page", "other", "back"],
            'info_sys': ["back"]
        };

        main_root = spawn node::state(
                                title="Greeting", 
                                message="Hi, welcome to V75. What would you like to build today?", 
                                prompts=all_prompts['starter_prompts']
                            );
       
        for i in all_prompts.d::keys {
            current_node = spawn main_root -[transition(intent=i)]-> node::state(
                                title=i,
                                message="What kind of " + i + " would you like to build?",
                                prompts=all_prompts[i]
                            );

            current_node -[transition(intent="back")]-> main_root;
            
            for x in all_prompts[i] {
                new_node = spawn current_node -[transition(intent=x)]-> node::state (
                            title=x,
                            message="Tell us about the " + x + " you'd like to build",
                            prompts=["back"]
                        );
                new_node -[transition(intent="back")]-> current_node;
            }

            quit_node = spawn node::state(title="Quit", message="quitting...", prompts="");
        }

    }

}