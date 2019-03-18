{*******************************************************}
{                                                       }
{       Projeto Teste P�s-Delphi                        }
{                                                       }
{       Copyright (C) 2019 Unoesc                       }
{                                                       }
{*******************************************************}
unit entity.formacao;

interface

uses
  DB,
  Classes,
  SysUtils,
  Generics.Collections,

  /// orm
  ormbr.types.blob,
  ormbr.types.lazy,
  ormbr.types.mapping,
  ormbr.types.nullable,
  ormbr.mapping.Classes,
  ormbr.mapping.register,
  ormbr.mapping.attributes;

type

  [ Entity ]
  [ Table('formacao', 'Tipo de forma��o do profission') ]
  [ PrimaryKey('id', AutoInc, Ascending, True, 'Chave prim�ria') ]
//  [ Indexe('pk_formacao','id', '')]
  [ Sequence('formacao') ]
  [ OrderBy('descricao') ]
  TFormacao = class
  private
    fdescricao: string;
    fid       : integer;
  public
    [ Restrictions([ NoUpdate, NotNull ]) ]
    [ Column('id', ftInteger) ]
    [ Dictionary('C�digo', 'Mensagem valida��o', '', '', '', tacenter) ]
    property id: integer read fid write fid;

    [Restrictions([NotNull])]
    [ Column('descricao', ftString, 60) ]
    [ Dictionary('Descri��o', 'Mensagem valida��o', '', '', '', tacenter) ]
    property descricao: string read fdescricao write fdescricao;
  end;

implementation

initialization
TRegisterClass.RegisterEntity (TFormacao);

end.
