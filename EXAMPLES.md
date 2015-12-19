# ALGEA - Examples

## Creating matrices

```eiffel
m := al.matrix (3, 2)
```

| 0 | 0 |
|---|---|
| 0 | 0 |
| 0 | 0 |

```eiffel
m := al.matrix_filled (4, 4, 1.0)
```

| 1 | 1 | 1 | 1 |
|---|---|---|---|
| 1 | 1 | 1 | 1 |
| 1 | 1 | 1 | 1 |
| 1 | 1 | 1 | 1 |

## Reading and setting single fields

```eiffel
m[1,2] := 47
m[4,4] := m[1,2] * 2
```

| 1 | 47 | 1 | 1  |
|---|----|---|----|
| 1 | 1  | 1 | 1  |
| 1 | 1  | 1 | 1  |
| 1 | 1  | 1 | 94 |

## Manipulating rows

```eiffel
m.row (2).fill (2)
```

| 1 | 47 | 1 | 1  |
|---|----|---|----|
| 2 | 2  | 2 | 2  |
| 1 | 1  | 1 | 1  |
| 1 | 1  | 1 | 94 |

```eiffel
m.row (4).add (-2)
```

| 1  | 47 | 1  | 1  |
|----|----|----|----|
| 2  | 2  | 2  | 2  |
| 1  | 1  | 1  | 1  |
| -1 | -1 | -1 | 92 |

```eiffel
m.row (3).fill_sequence (5, 2)
```

| 1  | 47 | 1  | 1  |
|----|----|----|----|
| 2  | 2  | 2  | 2  |
| 5  | 7  | 9  | 11 |
| -1 | -1 | -1 | 92 |

## Manipulating columns


## Diagonal


## All elements


## Labels


 