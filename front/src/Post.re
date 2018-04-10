
let component = ReasonReact.statelessComponent("Post");

let make = (~text, ~name, _children) => {
  ...component,
  render: _self =>
    <li className="post-element">
      <span>(ReasonReact.stringToElement(text))</span>
      <span>(ReasonReact.stringToElement(name))</span>
    </li>
}