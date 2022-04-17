import {*} with "./graph2.jac";
import {*} with "./walker.jac";
walker init {
    //has to spawn graph within here
    root {
        //spawn
        spawn here --> graph::main_graph; //basically spawns the graph here. Thats why here is used.
        //spawn here --> --> graph::main_graph;
        //spawn here and it will create the graph and edge together
        spawn --> walker::talker; //how to spawn a walker
        //spawn -->[0] walker::talker is equivalent to above
        //two arrows are different
        //spawns the walker talker on the node that I am pointing to
    }
}