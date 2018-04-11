
open PostList.Post_;

module Decode = {
  let post = json =>
    Json.Decode.{
      text: field("text", string, json),
      name: field("name", string, json)
    };

  let posts = json =>
    Json.Decode.(
      json
      |> field("posts", list(post))
    );
};

type state = {
  input: post,
  posts: list(post)
};

type action
  = InputText(string)
  | InputName(string)
  | FetchPostList
  | SuccessPostList(list(post))
  | CllickPost
  | SuccessPost(post)
  | HttpError;

let reducer =
  (action, { input: { text, name } as input, posts } as state) =>
    switch (action) {
    | InputText(newText) =>
        ReasonReact.Update({ input: { text: newText, name }, posts });
    | InputName(newName) =>
        ReasonReact.Update({ input: { text, name: newName }, posts });
    | FetchPostList =>
        ReasonReact.UpdateWithSideEffects(
          state,
          self =>
            Js.Promise.(
              Fetch.fetch("/api/posts")
              |> then_(Fetch.Response.json)
              |> then_(
                json =>
                  json
                  |> Decode.posts
                  |> (posts => self.send(SuccessPostList(posts)))
                  |> resolve
              )
              |> catch(err => {
                Js.log(err);
                resolve(self.send(HttpError));
              })
              |> ignore
            )
        );
    | SuccessPostList(newPosts) =>
        ReasonReact.Update({ input, posts: newPosts });
    | CllickPost =>
        ReasonReact.UpdateWithSideEffects(
          state,
          self => {
            let { text, name } = state.input;
            let payload = Js.Dict.empty();
            Js.Dict.set(payload, "text", text);
            Js.Dict.set(payload, "name", name);
            Js.Promise.(
              Fetch.fetchWithInit("/api/posts", Fetch.RequestInit.make(~method_=Post, ()))
              |> then_(_res => resolve(self.send(SuccessPost(input))))
              |> catch(_err => resolve(self.send(HttpError)))
              |> ignore
            );
          }
        );
    | SuccessPost(post) =>
        ReasonReact.Update({ input, posts: [post, ...posts] });
    | HttpError => {
        Js.log("Http error.");
        ReasonReact.Update(state); /* TODO: Error handle. */
      }
    };

let initialState = () => { input: { text: "", name: "" }, posts: [] };

let component =
  ReasonReact.reducerComponent("GuestBook");

let make = (_children) => {
  ...component,
  reducer,
  initialState,
  didMount: self => {
    self.send(FetchPostList);
    ReasonReact.NoUpdate;
  },
  render: ({state, send}) => {
    let {input, posts} = state;
    let get_value = event => ReactDOMRe.domElementToObj(ReactEventRe.Form.target(event))##value;
    <div>
      <form>
        <div>
          <input _type="text" value=input.text onChange=(e => send(InputText(get_value(e)))) />
        </div>
        <div>
          <input _type="text" value=input.name onChange=(e => send(InputName(get_value(e)))) />
        </div>
        <div>
          <button onClick=(_e => send(CllickPost))>
            (ReasonReact.stringToElement("Post!"))
          </button>
        </div>
      </form>
      <PostList posts=posts />
    </div>
  }
};