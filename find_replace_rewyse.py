#!/usr/bin/env python3
"""
Remplacer TOUS les 'rewyse' par 'welever' dans le répertoire.
"""

import os
import re

REPLACEMENTS = [
    ("rewyse-ai", "welever-product-kit"),
    ("Rewyse AI", "Welever Product Kit"),
    ("Rewyse", "Welever"),
    ("rewyse", "welever"),
    ("REWYSE", "WELEVER"),
]

SKIP_DIRS = {".git", ".optimizer", "__pycache__", "node_modules", ".env"}
SKIP_FILES = {"find_replace_rewyse.py"}

def should_skip(path):
    """Vérifier si on doit skip ce chemin."""
    for skip_dir in SKIP_DIRS:
        if skip_dir in path.split(os.sep):
            return True
    return False

def process_file(filepath):
    """Traiter un fichier : find & replace."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except (UnicodeDecodeError, IsADirectoryError):
        return False

    original_content = content

    # Faire les replacements (order matters!)
    for old, new in REPLACEMENTS:
        content = content.replace(old, new)

    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True

    return False

def main():
    root_dir = os.getcwd()
    files_changed = 0
    files_processed = 0

    print(f"Répertoire : {root_dir}")
    print(f"Remplacements : {len(REPLACEMENTS)}\n")

    for dirpath, dirnames, filenames in os.walk(root_dir):
        # Skip les dossiers
        dirnames[:] = [d for d in dirnames if d not in SKIP_DIRS]

        for filename in filenames:
            if filename in SKIP_FILES:
                continue

            filepath = os.path.join(dirpath, filename)

            if should_skip(filepath):
                continue

            files_processed += 1

            if process_file(filepath):
                rel_path = os.path.relpath(filepath, root_dir)
                print(f"✅ {rel_path}")
                files_changed += 1

    print(f"\n{'='*60}")
    print(f"Fichiers traités : {files_processed}")
    print(f"Fichiers modifiés : {files_changed}")
    print(f"{'='*60}")

if __name__ == "__main__":
    main()
