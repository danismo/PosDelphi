{*******************************************************}
{                                                       }
{       Projeto Teste P�s-Delphi                        }
{                                                       }
{       Copyright (C) 2019 Unoesc                       }
{                                                       }
{*******************************************************}
unit View.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Grids,

  Entity.Pessoa,

  Controller.Interfaces,
  Controller.Cadastro.Pessoa;

type
  TStringGridHack = class(TStringGrid)
  protected
    procedure DeleteRow(ARow: Longint); reintroduce;
    procedure InsertRow(ARow: Longint);
  end;

  TPrincipal = class(TForm)
    STGridPessoa: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    procedure DefinicaoStringGrid;
    procedure PreencherStringGrid(ALista: TObjectList<TPessoa>; AIndex: Integer = 0);
    procedure AdicionarLinhaStringGrid(AObject: TPessoa);
    function RetornaSexo(ASelecao : TSexo): string;
    { Private declarations }
  public
    FControllerPessoa : iControllerCadastroPessoa;
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation


{$R *.dfm}

procedure TPrincipal.DefinicaoStringGrid;
var
  iFor: Integer;
begin
  STGridPessoa.ColCount := 8;

  for iFor := 0 to pred(STGridPessoa.ColCount) do
    STGridPessoa.ColWidths[iFor] := 150;

  STGridPessoa.Cols[0].Text := 'ID';
  STGridPessoa.Cols[1].Text := 'Nome';
  STGridPessoa.Cols[2].Text := 'Sobrenome';
  STGridPessoa.Cols[3].Text := 'Telefone';
  STGridPessoa.Cols[4].Text := 'Email';
  STGridPessoa.Cols[5].Text := 'Matricula';
  STGridPessoa.Cols[6].Text := 'Nascimento';
  STGridPessoa.Cols[7].Text := 'Sexo';
end;

procedure TPrincipal.PreencherStringGrid(ALista: TObjectList<TPessoa>; AIndex: Integer);
var
  LFor: Integer;
begin
  for LFor := AIndex to ALista.Count -1 do
  begin
    // Adiciona a lista de objetos geral.
    AdicionarLinhaStringGrid(ALista.Items[LFor]);
    TStringGridHack(STGridPessoa).InsertRow(1);
  end;
  if STGridPessoa.RowCount > 1 then
    STGridPessoa.FixedRows := 1;
end;

function TPrincipal.RetornaSexo(ASelecao: TSexo): string;
begin
case ASelecao of
  Masculino: Result := 'Masculino';
  Feminino: Result := 'Feminino';
end;
end;

procedure TPrincipal.FormCreate(Sender: TObject);
begin
  FControllerPessoa := TControllerCadastroPessoa.New;
  if Assigned(FControllerPessoa) then
  begin
    DefinicaoStringGrid;
    if Assigned(FControllerPessoa.Pessoa.GetListaPessoa) then
      PreencherStringGrid(FControllerPessoa.Pessoa.GetListaPessoa);
  end;
end;

procedure TPrincipal.AdicionarLinhaStringGrid(AObject: TPessoa);
begin
  STGridPessoa.Cells[0, STGridPessoa.RowCount] := inttostr(AObject.id);
  STGridPessoa.Cells[1, STGridPessoa.RowCount] := AObject.nome;
  STGridPessoa.Cells[2, STGridPessoa.RowCount] := AObject.sobrenome;
  STGridPessoa.Cells[3, STGridPessoa.RowCount] := AObject.telefone;
  STGridPessoa.Cells[4, STGridPessoa.RowCount] := AObject.email;
  STGridPessoa.Cells[5, STGridPessoa.RowCount] := IntToStr(AObject.matricula);
  STGridPessoa.Cells[6, STGridPessoa.RowCount] := DateToStr(AObject.datanascimento);
  STGridPessoa.Cells[7, STGridPessoa.RowCount] := RetornaSexo(AObject.sexo);
end;

procedure TStringGridHack.DeleteRow(ARow: Longint);
var
  GemRow: Integer;
begin
  GemRow := Row;
  if RowCount > FixedRows + 1 then
    inherited DeleteRow(ARow)
  else
    Rows[ARow].Clear;
  if GemRow < RowCount then
    Row := GemRow;
end;

procedure TStringGridHack.InsertRow(ARow: Longint);
var
  GemRow: Integer;
begin
  GemRow := Row;
  while ARow < FixedRows do
    Inc(ARow);
  RowCount := RowCount + 1;
  Row := GemRow;
end;

end.



