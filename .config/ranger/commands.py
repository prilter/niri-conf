from ranger.api.commands import Command

class nvim(Command):
    def execute(self):
        import os
        self.fm.run('nvim "{}"'.format(self.fm.thisdir.path))

class terminal(Command):
    def execute(self):
        import os
        self.fm.run(os.environ.get('SHELL', '/bin/zsh'))

class unzip(Command):
    import os
    def execute(self):
        import subprocess

        file = self.fm.thisfile # GET THE CURRENTLY SELECTED
        if not file: # IS EXIST
            self.fm.notify("No file selected!", bad=True); return
        if not file.is_file or not file.path.lower().endswith('.zip'): # IS ".zip"
            self.fm.notify("Selected file is not a .zip archive!", bad=True); return

        self.fm.execute_command(f"unzip {file.relative_path}")

class vino(Command):
    def execute(self):
        import os
        self.fm.run('vino "{}"'.format(self.fm.thisdir.path))
