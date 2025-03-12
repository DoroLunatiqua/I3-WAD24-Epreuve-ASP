CREATE PROCEDURE [dbo].[SP_User_Delete]

-- On ne peut pas le Delete totalement mais on désactive le compte

	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
