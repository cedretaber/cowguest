
module Post_ {
  type post = {
    text: string,
    name: string
  };
};

open Post_;

let componens = ReasonReact.statelessComponent("PostList");

let make = (~posts, _children) => {
  ...componens,
  render: _self => {
    let postList = List.map(
      ({text, name}) => <Post text=text name=name />,
      posts
    ) |> Array.of_list;
    <ul className="post-list"> (ReasonReact.arrayToElement(postList)) </ul>
  }
};