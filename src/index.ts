import {Elm} from "./Main.elm";

const element = document.getElementById("app");
if (element) {
    const app = Elm.Main.init({node: element, flags: null});
    app.ports.alert.subscribe((msg) => {
        alert(msg);
        app.ports.reply.send(`"${msg}" was alerted`);
    });

}