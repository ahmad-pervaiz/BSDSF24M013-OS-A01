# Operating Systems Assignment 1 — Analysis Report

---

## Part 2: Multi-file Project Report Questions

### 1. Explain the linking rule in this part's Makefile: `$(TARGET): $(OBJECTS)`. How does it differ from a Makefile rule that links against a library?
* **Direct Object Linking (`$(TARGET): $(OBJECTS)`):** This rule takes compiled object files (`.o` files) and passes them directly to the compiler/linker to construct a single executable file[cite: 1]. Every listed object file is merged into the output binary[cite: 1].
* **Difference from Library Linking:** When linking against a library, the rule references an archive or shared library file (using flags like `-Llib -lmyutils`) instead of listing individual `.o` files. The linker searches through the library and only extracts or links the specific function symbols required by the program rather than embedding all raw object files explicitly.

### 2. What is a Git tag and why is it useful in a project? What is the difference between a simple tag and an annotated tag?
* **Git Tag Concept:** A Git tag is a reference point or bookmark pointing to a specific commit in your Git history, typically used to mark stable release versions (e.g., `v1.0.0`)[cite: 1].
* **Usefulness:** It allows developers to mark specific commit checkpoints without relying on moving branch pointers[cite: 1].
* **Lightweight vs. Annotated Tag:**
  * **Lightweight Tag:** A simple pointer directly to a commit hash with no extra metadata attached.
  * **Annotated Tag:** Stored as a full Git object in the database containing the tagger's name, email, creation date, and a custom message (created using `git tag -a`)[cite: 1].

### 3. What is the purpose of creating a "Release" on GitHub? What is the significance of attaching binaries (like your client executable) to it?
* **Purpose of GitHub Release:** A GitHub Release packages software versions, release notes, and assets for end-users based on a Git tag[cite: 1].
* **Significance of Attaching Binaries:** Attaching compiled binaries (like `bin/client`) allows users to download and run the application directly without needing a local build system, C compiler, or source code knowledge[cite: 1].

---

## Part 3: Static Library Report Questions

### 1. Compare the Makefile from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?
* **Part 2 Makefile:** Compiled all `.o` files directly into a single executable binary in one step[cite: 1].
* **Part 3 Makefile:** Introduced an intermediate target rule to create an archive file (`lib/libmyutils.a`) using the archiver tool `ar rcs`[cite: 1]. The client linking rule was modified to link against the archive file using library search path flags (`-Llib -lmyutils`)[cite: 1].

### 2. What is the purpose of the `ar` command? Why is `ranlib` often used immediately after it?
* **Purpose of `ar`:** The `ar` (archiver) command bundles multiple compiled object files (`.o`) into a single static library archive file (`.a`)[cite: 1].
* **Role of `ranlib`:** `ranlib` generates or updates an index of symbols inside the static archive, which allows the linker to perform symbol lookups faster[cite: 1]. *Note:* Modern `ar` commands using the `s` flag (e.g., `ar rcs`) generate this symbol index automatically, making an explicit call to `ranlib` unnecessary.

### 3. When you run `nm` on your `client_static` executable, are the symbols for functions like `mystrlen` present? What does this tell you about how static linking works?
* **Symbol Presence:** Yes, running `nm bin/client_static | grep mystrlen` shows that the symbol entry for `mystrlen` is present inside the final executable binary[cite: 1].
* **What This Demonstrates:** Static linking copies the machine code instructions of the library functions directly into the executable at compile time[cite: 1]. The resulting binary becomes fully self-contained and does not require `libmyutils.a` at runtime[cite: 1].

---

## Part 4: Dynamic Library Report Questions

### 1. What is Position-Independent Code (`-fPIC`) and why is it a fundamental requirement for creating shared libraries?
* **Position-Independent Code (`-fPIC`):** Machine code that executes correctly regardless of the absolute memory address where it is loaded in RAM[cite: 1].
* **Why Required:** Shared libraries (`.so`) are designed to be shared across multiple running processes in memory[cite: 1]. Since each process maps the shared library into a different virtual memory address space, the code must be position-independent to run properly everywhere without address relocations[cite: 1].

### 2. Explain the difference in file size between your static and dynamic clients. Why does this difference exist?
* **File Size Difference:** The `bin/client_static` file is noticeably larger than `bin/client_dynamic`[cite: 1].
* **Why It Exists:** Static linking includes the actual function implementations inside the binary executable file[cite: 1]. Dynamic linking leaves the function implementations inside `libmyutils.so` and only embeds stub references into `client_dynamic`, resulting in a much smaller executable size[cite: 1].

### 3. What is the `LD_LIBRARY_PATH` environment variable? Why was it necessary to set it for your program to run, and what does this tell you about the responsibilities of the operating system's dynamic loader?
* **`LD_LIBRARY_PATH` Concept:** An environment variable that specifies custom directory paths where the dynamic linker/loader (`ld.so`) searches for shared dynamic libraries (`.so`)[cite: 1].
* **Why Necessary:** Custom shared libraries placed in non-standard directories (such as `./lib`) are not searched by the system dynamic loader by default[cite: 1]. Setting `export LD_LIBRARY_PATH=$PWD/lib:$LD_LIBRARY_PATH` tells the loader where to locate `libmyutils.so` at launch[cite: 1].
* **Loader Responsibilities:** This shows that the OS dynamic loader is responsible for locating shared libraries at runtime, mapping them into the process memory space, and resolving unresolved function symbols before execution begins[cite: 1].
