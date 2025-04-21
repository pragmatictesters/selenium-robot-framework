## ✅ Step 1: Activate your virtual environment

Make sure you're in the project folder (`robot-demo`) and then run:

```bash
source venv/bin/activate
```

You should see `(venv)` appear in your terminal prompt — that’s how you know it’s active.

---

## ✅ Step 2: Check if `robot` is installed

With the virtual environment activated, run:

```bash
pip show robotframework
```

If it’s not installed, install it:

```bash
pip install robotframework
```

---

## ✅ Step 3: Run your Robot test

Now that the virtual environment is active and the package is installed, try:

```bash
robot hello.robot
```

If it works, you’ll see Robot Framework log output and your test will run in Chrome!

---

## ✅ Optional: Add `robot` to global PATH (for running without `venv`)

If you ever want to run `robot` without activating your virtual environment each time, you can install it globally:

```bash
pip install --user robotframework
```

Then restart your terminal and try `robot --version`.

