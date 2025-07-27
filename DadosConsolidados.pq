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
    CriarColunasExpandido = Table.ExpandRecordColumn(CriarColunas, "CriarColunas", {"Ano", "Empresa"}, {"Ano", "Empresa"}),
    TabelasExtraidas = Table.AddColumn(CriarColunasExpandido, "Tabela", each Excel.Workbook([Content], true)[Data]{0}, type table),
    TabelaCompleta = Table.AddColumn(
        TabelasExtraidas, 
        "TabelaCompleta", each 
        let
            _Ano = [Ano],
            _Empresa = [Empresa]
        in
            Table.AddColumn([Tabela],"DadosAdicionais", each [Ano = _Ano, Empresa = _Empresa])
        , type [Ano = text, Empresa = text]
    ),
    FuncaoInvocada = Table.AddColumn(TabelaCompleta, "TabelaTratada", each Tratamento([TabelaCompleta]), type table [Empresa = text, Cod item = text, Data = date, Consumo = number]),
    ColunaSelecionada = Table.SelectColumns(FuncaoInvocada,{"TabelaTratada"})
in
    ColunaSelecionada