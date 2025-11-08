import os
import re
from datetime import datetime

import piexif
from PIL import ExifTags, Image


def need_conv(file_path):
    img_exts = {".jpg", ".jpeg", ".png", ".bmp", ".tiff", ".webp"}
    ext = os.path.splitext(file_path)[1].lower()
    if ext not in img_exts:
        return False
    try:
        with Image.open(file_path) as img:
            img.verify()
        return True
    except Exception:
        return False


def conv_img(src_path, dst_path, quality=80):
    with Image.open(src_path) as img:
        img = img.convert("RGB")
        exif_dict = piexif.load(img.info.get("exif", b""))

        if piexif.ImageIFD.Orientation in exif_dict["0th"]:
            exif_dict["0th"][piexif.ImageIFD.Orientation] = 1

        for tag in [piexif.ImageIFD.ImageWidth, piexif.ImageIFD.ImageLength]:
            exif_dict["0th"].pop(tag, None)

        exif_dict["thumbnail"] = None

        max_side = 1920
        w, h = img.size
        scale = min(max_side / w, max_side / h, 1)
        new_size = (int(w * scale), int(h * scale))
        if scale < 1:
            img = img.resize(new_size, Image.Resampling.LANCZOS)

        exif_bytes = piexif.dump(exif_dict)
        img.save(dst_path, "JPEG", quality=quality, optimize=True, exif=exif_bytes)


def make_img_path(src_path, dst_path, file_path, date_obj, counter):
    rel_path = os.path.relpath(file_path, src_path)
    rel_dirs = os.path.dirname(rel_path).split(os.sep)

    # Проверяем наличие каталога с "whats"
    has_whats = any("whats" in d.lower() for d in rel_dirs)

    filtered_dirs = []
    for d in rel_dirs:
        if not d:
            continue
        if d.lower().startswith("disk") or d.lower().startswith("part"):
            continue
        if re.fullmatch(r"[\d\W_()]+", d):
            continue
        filtered_dirs.append(d)

    year = date_obj.strftime("%Y")

    if has_whats:
        # Без месяца
        dst_dir = os.path.join(dst_path, year, *filtered_dirs)
    else:
        month = date_obj.strftime("%m")
        dst_dir = os.path.join(dst_path, year, month, *filtered_dirs)

    os.makedirs(dst_dir, exist_ok=True)
    fname = f"IMG_{date_obj.strftime('%Y%m%d')}_{counter}.jpg"
    return os.path.join(dst_dir, fname)


def get_image_date(file_path):
    try:
        img = Image.open(file_path)
        exif = img.info.get("exif")
        if exif:
            for tag, value in exif.items():
                decoded = ExifTags.TAGS.get(tag, tag)
                if decoded == "DateTimeOriginal":
                    print(f"Has image meta info: {file_path}")  # noqa: T201
                    return datetime.strptime(value, "%Y:%m:%d %H:%M:%S")
    except Exception:
        print(f"No meta info: {file_path}")  # noqa: T201

    t = os.path.getmtime(file_path)
    return datetime.fromtimestamp(t)


def copy_file_times(src_file, dst_file):
    """
    Копирует время доступа и модификации с src_file на dst_file.
    Время создания изменить нельзя.
    """
    stat = os.stat(src_file)
    os.utime(dst_file, (stat.st_atime, stat.st_mtime))


def convert_photos(src_path, dst_path):
    counter = 1
    for root, dirs, files in os.walk(src_path):
        for fname in files:
            src_file = os.path.join(root, fname)
            if not need_conv(src_file):
                continue

            date_obj = get_image_date(src_file)
            dst_file = make_img_path(src_path, dst_path, src_file, date_obj, counter)

            print(f"Конвертация: {src_file} -> {dst_file}")  # noqa: T201
            try:
                conv_img(src_file, dst_file)
                copy_file_times(src_file, dst_file)
                counter += 1
            except Exception as e:
                print(f"Ошибка при конвертации {src_file}: {e}")  # noqa: T201


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Конвертация архива фотографий")
    parser.add_argument("--src_path", required=True, help="Путь к архиву фотографий")
    parser.add_argument(
        "--dst_path", required=True, help="Путь для сохранения конвертированных фото"
    )
    args = parser.parse_args()

    convert_photos(args.src_path, args.dst_path)
