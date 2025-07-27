let
    Fonte = Folder.Files("Z:\certificacao\pq\base"),
    OutrasColunasRemovidas = Table.SelectColumns(Fonte,{"Content", "Name"}),
    CriarColunas = Table.AddColumn(
        OutrasColunasRemovidas, 
        "CriarColunas", 
        each
        let
            _Ano = Text.End(Text.BeforeDelimiter([Name],".xlsx"), 4)
        in
        [
            Ano = _Ano,
            Empresa = Text.BeforeDelimiter([Name], _Ano)
        ], type [Ano = text, Empresa = text]
    ),
    CriarColunasExpandido = Table.ExpandRecordColumn(CriarColunas, "CriarColunas", {"Ano", "Empresa"}, {"Ano", "Empresa"})
in
    CriarColunasExpandido