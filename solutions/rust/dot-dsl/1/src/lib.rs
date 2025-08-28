pub mod graph {
    use std::collections::HashMap;

    use graph_items::{edge::Edge, node::Node};

    #[derive(Debug, PartialEq, Eq)]
    pub struct Graph {
        pub nodes: Vec<Node>,
        pub edges: Vec<Edge>,
        pub attrs: HashMap<String, String>,
    }

    impl Graph {
        pub fn new() -> Self {
            Self {
                nodes: Vec::new(),
                edges: Vec::new(),
                attrs: HashMap::new(),
            }
        }

        pub fn with_nodes(mut self, nodes: &[Node]) -> Self {
            self.nodes.extend(nodes.iter().cloned());
            self
        }

        pub fn with_edges(mut self, edges: &[Edge]) -> Self {
            self.edges.extend(edges.iter().cloned());
            self
        }

        pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
            self.attrs
                .extend(attrs.iter().map(|(a, b)| (a.to_string(), b.to_string())));
            self
        }

        pub fn node(&self, node: &str) -> Option<Node> {
            self.nodes.iter().filter(|n| n.name == node).next().cloned()
        }
    }

    pub mod graph_items {
        pub mod edge {
            use std::collections::HashMap;

            #[derive(Clone, PartialEq, Eq, Debug)]
            pub struct Edge {
                nodes: (String, String),
                attrs: HashMap<String, String>,
            }

            impl Edge {
                pub fn new(node_a: &str, node_b: &str) -> Self {
                    Self {
                        nodes: (node_a.to_string(), node_b.to_string()),
                        attrs: HashMap::new(),
                    }
                }

                pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
                    self.attrs
                        .extend(attrs.iter().map(|(a, b)| (a.to_string(), b.to_string())));
                    self
                }

                pub fn attr(&self, attr: &str) -> Option<&str> {
                    self.attrs.get(attr).map(|a| a.as_str())
                }
            }
        }
        pub mod node {
            use std::collections::HashMap;

            #[derive(Clone, PartialEq, Eq, Debug)]
            pub struct Node {
                pub name: String,
                attrs: HashMap<String, String>,
            }

            impl Node {
                pub fn new(name: &str) -> Self {
                    Self {
                        name: name.to_string(),
                        attrs: HashMap::new(),
                    }
                }

                pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
                    self.attrs
                        .extend(attrs.iter().map(|(a, b)| (a.to_string(), b.to_string())));
                    self
                }

                pub fn attr(&self, attr: &str) -> Option<&str> {
                    self.attrs.get(attr).map(|s| s.as_str())
                }
            }
        }
    }
}
