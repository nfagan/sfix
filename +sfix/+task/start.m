function start(varargin)

program = sfix.task.setup( varargin{:} );
err = [];

try
  sfix.task.run( program );
catch err
end

delete( program );

if ( ~isempty(err) )
  rethrow( err );
end

end