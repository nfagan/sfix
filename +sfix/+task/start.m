
function err = start(conf)

%   START -- Attempt to setup and run the task.
%
%     OUT:
%       - `err` (double, MException) -- 0 if successful; otherwise, the
%         raised MException, if setup / run fails.

if ( nargin < 1 || isempty(conf) )
  conf = sfix.config.load();
else
  sfix.util.assertions.assert__is_config( conf );
end

try
  opts = sfix.task.setup( conf );
catch err
  sfix.task.cleanup();
  sfix.util.print_error_stack( err );
  return;
end

try
  err = 0;
  sfix.task.run( opts );
  sfix.task.cleanup();
catch err
  sfix.task.cleanup();
  sfix.util.print_error_stack( err );
end

end