# -*- mode: python ; coding: utf-8 -*-


a = Analysis(
    ['L:\\Glide Plate Sheet Generator\\AVW_Generator\\glide_plate_generator.py'],
    pathex=[],
    binaries=[],
    datas=[('L:\\Glide Plate Sheet Generator\\AVW_Generator\\logo.jpeg', '.'), ('L:\\Glide Plate Sheet Generator\\AVW_Generator\\plate_middle.png', '.'), ('L:\\Glide Plate Sheet Generator\\AVW_Generator\\plate_filler.jpeg', '.'), ('L:\\Glide Plate Sheet Generator\\AVW_Generator\\plate_drive.jpeg', '.'), ('L:\\Glide Plate Sheet Generator\\AVW_Generator\\schematic.png', '.')],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='AVW_Glide_Plate_Generator',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
