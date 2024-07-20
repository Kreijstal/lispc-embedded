def generate_c_header(lisp_file, header_file):
    with open(lisp_file, "r") as f:
        lisp_code = f.read()

    # Escape special characters for a valid C string literal
    escaped_lisp_code = lisp_code.replace('\\', '\\\\') \
                                  .replace('"', '\\"') \
                                  .replace('\n', '\\n') 

    with open(header_file, "w") as f:
        f.write('#ifndef STDLIB_LISP_H\n')
        f.write('#define STDLIB_LISP_H\n\n')
        f.write(f'const char* stdlib_lisp = "{escaped_lisp_code}";\n\n')
        f.write('#endif // STDLIB_LISP_H\n')

if __name__ == "__main__":
    generate_c_header("stdlib.lisp", "stdlib_lisp.h")
