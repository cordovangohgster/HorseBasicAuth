program BasicAuthentication;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.BasicAuthentication, // It's necessary to use the unit
  System.SysUtils;

begin
  // It's necessary to add the middleware in the Horse:
  THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      // Here inside you can access your database and validate if username and password are valid
      Result := AUsername.Equals('Jesus') and APassword.Equals('Cordova');
    end));

  // The default header for receiving credentials is "Authorization".
  // You can change, if necessary:
  // THorse.Use(HorseBasicAuthentication(MyCallbackValidation, THorseBasicAuthenticationConfig.New.Header('X-My-Header-Authorization')));

  // You can also ignore routes:
  // THorse.Use(HorseBasicAuthentication(MyCallbackValidation, THorseBasicAuthenticationConfig.New.SkipRoutes(['/ping'])));

  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(9000);
end.
