function state = cs_delay(program, conf)

state = ptb.State();
state.Name = 'cs_delay';
state.Duration = conf.TIMINGS.time_in.cs_delay;

state.Entry = @(state) entry(state, program);
state.Exit = @(state) exit(state, program);

end

function entry(state, program)

data = sfix.util.data_this_trial( program );
data.event_times.cs_delay.entry = elapsed( program.Value.task );

flip( program.Value.window );

end

function exit(state, program)

next( state, program.Value.states('cs_reward') );

end