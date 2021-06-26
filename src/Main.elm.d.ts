export namespace Elm {
    namespace Main {
        export interface App {
            ports: {
                alert: {
                    subscribe(callback: (data: string) => void): void
                }
                reply: {
                    send(data: string): void
                }
            };
        }

        export function init(options: {
            node?: HTMLElement | null;
            flags: null;
        }): Elm.Main.App;
    }
}