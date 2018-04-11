
let component = ReasonReact.statelessComponent("Post");

let make = (~text, ~name, _children) => {
  ...component,
  render: _self =>
    <li className="post-element">
      <span className="text">(ReasonReact.stringToElement(text))</span>
      <span className="name">(ReasonReact.stringToElement(name))</span>
    </li>
}