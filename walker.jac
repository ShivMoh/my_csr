walker talker {
    can use.enc_question, use.enc_answer;
    state {//when you're on a state node, this is the code you run.
        std.out(here.message, here.prompts); //here references the message on the node that is here
        choices = here.prompts;

        question = std.input("> ");
        
        q_enc = use.enc_question(question);
        a_enc = use.enc_answer(choices);

        a_scores=[];
        index = 0;

        for i in a_enc:
            a_scores.l::append(vector.cosine_sim(q_enc, i));

        a_scores.l::sort;

        for i=0 to i<a_enc.length by i+=1:
            if(a_scores[-1] == vector.cosine_sim(q_enc, a_enc[i])) {
                index = i;
            }

        utterance = choices[index];

        if (utterance == "quit"): disengage;

        take -[transition(intent == utterance)]-> node::state else {
            take here;//if nothing matches the intent
        }
        //if that matches that, it will transition to state
        //take checks for edge?
    }
}