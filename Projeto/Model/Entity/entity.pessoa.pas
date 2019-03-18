{*******************************************************}
{                                                       }
{       Projeto Teste P�s-Delphi                        }
{                                                       }
{       Copyright (C) 2019 Unoesc                       }
{                                                       }
{*******************************************************}
unit entity.pessoa;

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
  [Enumeration(etChar,'M,F')]
  TSexo = (Masculino, Feminino);

  [ Entity ]
  [ PrimaryKey('id',AutoInc, nosort,true, 'chave primaria') ]
  [Sequence('pessoaid')]
  [ Table('pessoa', 'pessoas do sistema') ]
  TPessoa = class
  private
    fid            : integer;
    fmatricula     : integer;
    Fnome          : string;
    Fsobrenome     : string;
    Femail         : string;
    Ftelefone      : string;
    fsexo          : TSexo;
    fdatanascimento: TDate;
  public
    [ Restrictions([ NoUpdate, NotNull ]) ]
    [ Column('id', ftInteger) ]
    [ Dictionary('C?digo', 'Mensagem valida��o', '', '', '', tacenter) ]
    property id: integer read fid write fid;

    [ Restrictions([ Unique ]) ]
    [ Column('matricula', ftInteger) ]
    [ Dictionary('Matr?cula', 'Mensagem valida��o', '', '', '', tacenter) ]
    property matricula: integer read fmatricula write fmatricula;

    [ Column('nome', ftString, 60) ]
    [ Dictionary('Nome', 'Mensagem valida��o', '', '', '', tacenter) ]
    property nome: string read Fnome write Fnome;

    [ Column('sobrenome', ftString, 60) ]
    [ Dictionary('Sobrenome', 'Mensagem valida��o', '', '', '', tacenter) ]
    property sobrenome: string read Fsobrenome write Fsobrenome;

    [ Column('email', ftString, 100) ]
    [ Dictionary('E-mail', 'Mensagem valida��o', '', '', '', tacenter) ]
    property email: string read Femail write Femail;

    [ Column('telefone', ftString, 15) ]
    [ Dictionary('Telefone', 'Mensagem valida��o', '', '', '', tacenter) ]
    property telefone: string read Ftelefone write Ftelefone;

    [ Column('sexo', ftString, 1) ]
    [ Dictionary('Sexo', 'Mensagem valida��o', '', '', '', tacenter) ]
    property sexo: TSexo read fsexo write fsexo;

    [ Column('datanascimento', ftDate) ]
    [ Dictionary('Nascimento', 'Mensagem valida��o', '', '', '', tacenter) ]
    property datanascimento: TDate read fdatanascimento write fdatanascimento;
  end;

implementation

{ TPessoa }

initialization
TRegisterClass.RegisterEntity (TPessoa);

end.
