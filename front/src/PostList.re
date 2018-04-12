
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
    let postList = List.mapi(
      (idx, ({text, name})) => <Post key=string_of_int(idx) text=text name=name />,
      posts
    ) |> Array.of_list;
    <ul className="uk-list uk-list-striped post-list"> (ReasonReact.arrayToElement(postList)) </ul>
  }
};