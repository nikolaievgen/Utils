import os
import tempfile
import pytest

# Подключаем функцию, которую тестируем
from imgs.utils.dir_names import get_dir_names

def create_test_structure(root):
    """
    Создает временную структуру каталогов для тестирования.
    """
    dir1 = os.path.join(root, "A")
    os.mkdir(dir1)
    dir2 = os.path.join(root, "B")
    os.mkdir(dir2)
    dir3 = os.path.join(dir1, "C")
    os.mkdir(dir3)
    dir4 = os.path.join(dir2, "A")  # То же имя каталога, проверка уникальности
    os.mkdir(dir4)
    dir5 = os.path.join(dir1, "D")
    os.mkdir(dir5)
    # Добавим файл, чтобы убедиться, что он не попадает в результат
    file_path = os.path.join(root, "file.txt")
    open(file_path, "w").close()
    return root

@pytest.fixture
def temp_dir():
    with tempfile.TemporaryDirectory() as tmpdir:
        yield tmpdir

def test_get_unique_sorted_subdir_names(temp_dir):
    create_test_structure(temp_dir)
    result = get_dir_names(temp_dir)
    assert result == ["A", "B", "C", "D"]

def test_empty_directory(temp_dir):
    result = get_dir_names(temp_dir)
    assert result == []

def test_nested_structure(temp_dir):
    # Добавим вложенную структуру
    os.makedirs(os.path.join(temp_dir, "X", "Y", "Z"))
    result = get_dir_names(temp_dir)
    assert result == ["X", "Y", "Z"]

def test_case_insensitive(temp_dir):
    os.mkdir(os.path.join(temp_dir, "a"))
    os.mkdir(os.path.join(temp_dir, "A1"))
    result = get_dir_names(temp_dir)
    # Ожидаем только уникальные имена, регистр важен
    assert result == ["A1", "a"]

def test_nonexistent_directory():
    with pytest.raises(FileNotFoundError):
        get_dir_names("/nonexistent/path")