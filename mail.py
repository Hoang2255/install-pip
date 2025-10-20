import os
import re
import random
import threading
import webbrowser
from multiprocessing import Pool, cpu_count
from tkinter import Tk, Button, Text, filedialog, END, Scrollbar, RIGHT, Y, BOTH, Label, StringVar, Frame

EMAIL_REGEX = re.compile(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b')

def extract_emails_from_file(file_path):
    emails = set()
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            emails.update(email.lower() for email in EMAIL_REGEX.findall(f.read()))
    except:
        pass
    return emails
# https://t.me/+PbbgNNGAWFhmYzRl 
def process_folder(folder_path):
    local = set()
    for file_name in os.listdir(folder_path):
        if file_name.endswith('.txt'):
            local.update(extract_emails_from_file(os.path.join(folder_path, file_name)))
    return local

def scan_main(root_folder, box):
    sub = [os.path.join(root_folder, d) for d in os.listdir(root_folder) if os.path.isdir(os.path.join(root_folder, d))]
    allm = set()
    with Pool(cpu_count()) as pool:
        for r in pool.map(process_folder, sub):
            allm.update(r)
    mails = list(allm)
    random.shuffle(mails)
    box.delete(1.0, END)
    for m in mails:
        box.insert(END, f"[ MAIL SCAN ] =-> {m}\n")
    open("Mail.txt", "w", encoding="utf-8").write("\n".join(mails))
    box.insert(END, f"\n✅ Done! Found {len(allm)} mails -> Mail.txt\n")
# https://t.me/+PbbgNNGAWFhmYzRl
def make_ui():
    root = Tk()
    root.title("Mail Scanner Panel")
    root.geometry("700x500")
    root.configure(bg="black")
    sel = StringVar(value="No folder selected")
    def choose():
        f = filedialog.askdirectory(title="Select Logs Folder")
        if f:
            sel.set(f)
    def start():
        f = sel.get()
        if os.path.isdir(f):
            threading.Thread(target=scan_main, args=(f, box), daemon=True).start()
        else:
            box.insert(END, "⚠ Select a folder first!\n")
    Label(root, textvariable=sel, fg="cyan", bg="black").pack(pady=5)
    Button(root, text="📂 Select Folder", command=choose, height=2, width=20, bg="#2196F3", fg="white").pack(pady=5)
    Button(root, text="▶ Start Scan", command=start, height=2, width=20, bg="#4CAF50", fg="white").pack(pady=5)
    s = Scrollbar(root)
    s.pack(side=RIGHT, fill=Y)
    global box
    box = Text(root, wrap="word", yscrollcommand=s.set, bg="black", fg="white")
    box.pack(expand=True, fill=BOTH)
    s.config(command=box.yview)
    f = Frame(root, bg="black")
    f.pack(pady=5)
    l = Label(f, text="Join channels TreTrau Network | Join Channel Free tools/data", fg="orange", bg="black", cursor="hand2")
    l.pack()
    l.bind("<Button-1>", lambda e: webbrowser.open("https://t.me/+PbbgNNGAWFhmYzRl"))
    root.mainloop()

if __name__ == "__main__":
    make_ui()