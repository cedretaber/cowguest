
let component = ReasonReact.statelessComponent("Post");

let make = (~text, ~name, _children) => {
  ...component,
  render: _self =>
    <li className="post-element">
      <div className="uk-grid">
        <div className="text uk-width-5-6@m">
          <span className="uk-margin-right">
            (ReasonReact.stringToElement(text))
          </span>
        </div>
        <div className="name uk-width-1-6@m">
          (ReasonReact.stringToElement(name))
        </div>
      </div>
    </li>
}