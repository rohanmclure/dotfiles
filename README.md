# About

I've found that using command line tools has had the lovely, continual effect of tuning my familiar with cli's, making the transition from simply consuming a tool to mocking up ad-hoc scripts very straight-forward.

That said, command line tools which serve as an interactive UI ought to serve you, rather than the other way round.

My dotfiles are a largely pragmatic set of config files for the following tools:

 - `neovim`
   - I'd want to say that my dotfiles are for vim users too
   - Can't say that yet though
   - Also includes config for `vscode-neovim`, providing identical mappings
 - `tmux`
   - Very simple `tmux` configuration with `junegunn/fzf` support
   - `C-b` as leader
   - `tmux` continuum and resurrect for automatic restoration
 - `zsh`
   - `starship` theme
   - `fzf` support
   - `vi` bindings
   - Installs all plugins for all cmdline tools on source

## Some Thoughts

My thought was to make the terminal a full ecosystem for all of my development needs. Invariably this will involve reinventing the wheel terribly however. I intend to catch and adapt to trends, and modernise my tooling where appropriate. Suggestions and forks welcome.

The frustration with reinventing the wheel here is that people's dotfiles rarely benefit any setup other than their own. For this reason, I strongly approve of attempts to produce de-facto 'distributions'. By this I mean initiatives such as:

 - `doom-neovim`
 - `oh-my-zsh`

An auxiliary goal is for my dotfiles to provide inspiration for how you can use these tools with your own preferred keybinds and workflows. I adopted `tmux` originally as a desktop environment replacement - but something about that feels wrong.

While many go the `i3`/tiling window manager approach to fix this problem, I prefer the idea that any arbitrary _DE_ should just be populated with programs that are developer-friendly. Personally, I think the modal editing of `vi` is an excellent innovation, on the proviso that the keybinds you pick ultimately work for you, the user.

The fact that `([Neo])vi[m]` is largely bound to a `TUI` erks me though. Modal editing was not a side-effect of the `TUI` nature really, it was an intended design decision for keyboard-friendliness. A good synergy arises when willingness to type leads to willingness to tinker with commands, leads to willingness to automate.

Check out my [blog](https://rmclure.me/blog/) for more unsolicited philosophising on the matter.

# Installation

```bash 
git clone https://github.com/rohanmclure/dotfiles
make install
zsh # Will do the setup for you.
```

Nothing complicated - simply symlinks in the source files to their destination. Plugins will be installed in your home directory as you require them.
