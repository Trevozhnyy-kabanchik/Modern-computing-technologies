# Решение уравнения Пуассона с использованием INMOST

Данный проект реализует решение двумерного уравнения Пуассона методом конечных разностей с использованием библиотеки INMOST (итерационный решатель BiCGStab + предобуславливатель ILU2).

## Установка библиотеки INMOST

Для начала необходимо скачать исходный код библиотеки (https://github.com/INMOST-DEV/INMOST):

```bash
git clone https://github.com/INMOST-DEV/INMOST.git
```

Затем скомпилировать и установить её в локальную папку:

```bash
mkdir INMOST-build
mkdir INMOST-install
cd INMOST-build/
cmake -DUSE_AUTODIFF=OFF -DUSE_MPI=OFF -DCMAKE_INSTALL_PREFIX=../INMOST-install ../INMOST
make all
make install
cd ..
```

## Сборка проекта

Перейдите в корневую папку проекта и выполните стандартную сборку через CMake:

```bash
mkdir build 
cd build
cmake ..
make
cd ..
```

## Запуск программы

Вы можете запустить исполняемый файл вручную из папки `build`.

Запуск с размером сетки по умолчанию (N = 100):

```bash
./build/solver
```

Запуск с заданным размером сетки (например, N = 248):

```bash
./build/solver 248
```

## Автоматизация экспериментов и графики

В проекте предусмотрен скрипт для автоматического проведения серии расчетов на разных сетках и построения графиков сходимости и времени работы.

Для работы графиков потребуются библиотеки Python:

```bash
sudo apt install python3-matplotlib python3-numpy
```

**Запуск серии тестов:**

```bash
./run_experiments.sh
```

Скрипт автоматически запустит решатель для набора сеток, сохранит данные в `results.csv` и сгенерирует графики `convergence_plot.png` и `time_plot.png` в корневой папке.