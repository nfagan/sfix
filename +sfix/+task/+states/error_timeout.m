function state = error_timeout(program, conf)

state = ptb.State();
state.Name = 'error_timeout';
state.Duration = conf.TIMINGS.time_in.error_timeout;

state.Entry = @(state) entry(state, program);
state.Exit = @(state) exit(state, program);

end

function entry(state, program)

flip( program.Value.window );

end

function exit(state, program)

next( state, program.Value.states('new_trial') );

end