import os
import sys


def get_dir_names(inputPath):
    dir_names = set()

    def recursive_scan(path):
        for name in os.listdir(path):
            full_path = os.path.join(path, name)
            if os.path.isdir(full_path):
                dir_names.add(name)
                recursive_scan(full_path)

    recursive_scan(inputPath)
    return sorted(dir_names)


if __name__ == "__main__":
    print(sys.argv)  # noqa: T201
    if len(sys.argv) != 2:
        print("Usage: python your_module.py <inputPath>")  # noqa: T201
        sys.exit(1)
    input_path = sys.argv[1]
    result = get_dir_names(input_path)
    for name in result:
        print(name)  # noqa: T201
