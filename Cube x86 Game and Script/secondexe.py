from pelinker import COFF, Executable
import sys

with open(sys.argv[1], "rb") as handle:
    coff = COFF(handle.read())

exe = Executable()

for section_name, section_permissions, section_data, relocations in coff.sections: #in questa sessione scriviamo nomi della sezione, permessi, contenuto e i relocations
    new_section = exe.add_section(section_name, section_permissions, section_data)
    if section_name == ".text":
        exe.entry_point = new_section.rva
    for reloc_name, reloc_offset, reloc_type in relocations:
        new_section.add_relocation_symbol(reloc_name, reloc_offset, reloc_type)

exe.import_symbols("user32.dll", ["MessageBeep", "MessageBoxA"])        #queste sono le librerie 
exe.import_symbols("kernel32.dll", ["ExitProcess"])
exe.import_symbols(
    "raylib.dll",
    [
        "InitWindow",
        "SetTargetFPS",
        "WindowShouldClose",
        "BeginDrawing",
        "ClearBackground",
        "DrawText",
        "EndDrawing",
        "CloseWindow",
        "GetWindowPosition"
    ])

with open(sys.argv[2], "wb") as handle:
    handle.write(exe.link())


#in questo caso quando eseguirò, nel mio terminale appariranno alla fine dei dati finali con i vari indirizzi che abbiamo scritto e accanto ad'essi ci saranni i numeri in cui il pelinker può mettere i miei indirizzi perchè in quel dato il valore risulta zero.  ad esempio MessageBeep nell'indirizzo 14
