```m
    (Tabela)=>

    let
        Fonte = Table.ExpandRecordColumn(Tabela, "DadosAdicionais", {"Ano", "Empresa"}, {"Ano", "Empresa"}),
        Unpivot = Table.UnpivotOtherColumns(Fonte, {"Cod item", "Ano", "Empresa"}, "Atributo", "Consumo"),
        LinhasFiltradas = Table.SelectRows(
            Unpivot, each 
            let
                _FinalAtributo = Text.AfterDelimiter([Atributo],"-")
            in
            Text.StartsWith([Atributo], "Cons") and 
            (
                _FinalAtributo = Text.End([Ano],2)
                or
                _FinalAtributo = ""
            )
        ),
        AtributoMesTratado = Table.TransformColumns(
            LinhasFiltradas, {
                {
                    "Atributo", each 
                    let
                        _PrimeiraPassada = Text.AfterDelimiter(_, "Cons "),
                        _StringProcurada = "mês ",
                        _SegundaPassada = 
                            if Text.StartsWith(_PrimeiraPassada, _StringProcurada) 
                                then Text.AfterDelimiter(_PrimeiraPassada, _StringProcurada) 
                                else Text.BeforeDelimiter(_PrimeiraPassada, "-")
                    in
                    _SegundaPassada, type text
                }
            }
        ),
        ColunaDataAdd = Table.AddColumn(
            AtributoMesTratado, 
            "Data", 
            each Date.From(
                "01/" & [Atributo] & "/" & [Ano], "pt-BR"
            ), type date
        ),
        ColunasSelecionadas = Table.SelectColumns(ColunaDataAdd,{"Empresa", "Cod item", "Data", "Consumo"})
    in
        ColunasSelecionadas
```