pip install robotframework
# CPS-Robotok

## Robot Framework projekt

Ez a projekt a Robot Framework teszteléséhez szükséges alapvető könyvtárstruktúrát tartalmazza.

### Könyvtárstruktúra
- `tests/`: Tesztesetek (Robot Framework .robot fájlok)
- `resources/`: Közös erőforrások (pl. .robot, .resource fájlok)
- `libraries/`: Saját vagy külső Python könyvtárak
- `results/`: Tesztfutási eredmények

### Használat
1. Telepítsd a Robot Framework-öt:
	```sh
	pip install robotframework
	```
2. Tesztek futtatása:
	```sh
	robot tests
	```

### Megjegyzések
- A projekt tartalmaz példafájlokat és képernyőmentéseket is.
- A `.gitignore` kizárja a `.venv`, `.vscode`, `*.htlm`, `*.png` fájlokat a verziókezelésből.
