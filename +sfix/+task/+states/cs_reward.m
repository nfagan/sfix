function state = cs_reward(program, conf)

state = ptb.State();
state.Name = 'cs_reward';
state.Duration = conf.TIMINGS.time_in.cs_reward;

state.Entry = @(state) entry(state, program);
state.Exit = @(state) exit(state, program);

end

function entry(state, program)

flip( program.Value.window );

data = sfix.util.data_this_trial( program );
data.event_times.cs_reward.entry = elapsed( program.Value.task );

sfix.util.deliver_reward( program, 1, data.conditioned_reward_size );

end

function exit(state, program)

next( state, program.Value.states('iti') );

end